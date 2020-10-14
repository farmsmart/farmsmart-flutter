// Mock Strings --------------

import 'package:farmsmart_flutter/model/entities/mock/MockString.dart';

MockString mockExternalLinks = MockString(library: [
  "https://chat.whatsapp.com/BwzNV2WEFAqLDdvTFUljte",
  "https://www.tripadvisor.com/Attractions-g294206-Activities-c47-t122-Kenya.html",
  "https://en.wikipedia.org/wiki/Agriculture_in_Kenya",
]);

MockString mockTitleText = MockString(library: [
  "Title example",
  "Average title",
  "Ideal title",
  "Short",
  "Longest acceptable title",
  "Unacceptably long title that is way to wordy and is not a good real world example, but tests the limits."
]);

MockString mockPlainText = MockString(library: [
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
]);

MockString mockRichTextNoImage = MockString(library: [
  """<p><abbr>ABBR</abbr>, <acronym>ACRONYM</acronym> or <span style="border-bottom: 1px dotted">inline style</span></p>
<p><b>B</b>, <strong>STRONG</strong> or <span style="font-weight: bold">inline style</span></p>
<p><em>EM</em>, <i>I</i> or <span style="font-style: italic">inline style</span></p>
<p><u>U</u> or <span style="text-decoration: underline">inline</span> <span style="border-bottom: 1px">style</span></p>
<p><span style="color: #ff0000">Red</span>, <span style="color: #00ff00">green</span>, <span style="color: #0000ff">blue</span></p>
<p>
  <span style="text-decoration: line-through">
    <span style="text-decoration: overline">
      <span style="text-decoration: underline">
        All decorations...
        <span style="text-decoration: none">and none</span>
      </span>
    </span>
  </span>
</p>""",
  """<ul>
  <li>One</li>
  <li>Two</li>
  <li>Three</li>
</ul>""",
  """<ol>
  <li>One</li>
  <li>
    Two
    <ul>
      <li>2.1</li>
      <li>
        2.2
        <ul>
          <li>2.2.1</li>
          <li>2.2.2</li>
        </ul>
      </li>
      <li>2.3</li>
    </ul>
  </li>
 
 <li>Three</li>
  <li>Four</li>
  <li>Five</li>
  <li>Six</li>
  <li>Seven</li>
  <li>Eight</li>
  <li>Nine</li>
  <li>Ten</li>
  <li>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nibh quam, sodales in sollicitudin ut, scelerisque non sapien. Nam nec mi malesuada libero euismod tincidunt sit amet mattis ipsum. Etiam dapibus sem ac accumsan elementum. Vivamus mattis at diam ac pellentesque. Sed id eros condimentum, dignissim risus id, semper enim. Etiam tempor mauris id lorem fringilla, dapibus feugiat enim placerat. In hac habitasse platea dictumst. Nam est felis, accumsan et sapien ac, molestie convallis sapien. Vivamus ligula sapien, ultrices quis nisl ac, blandit hendrerit massa. Maecenas eleifend, nisi eget commodo mollis, elit magna pellentesque odio, sit amet auctor quam nibh vel purus. Integer ultricies lacinia ipsum, in tincidunt erat finibus eget.</li>
</ol>"""
]);

MockString mockRichText = MockString(library: [
  """<p><abbr>ABBR</abbr>, <acronym>ACRONYM</acronym> or <span style="border-bottom: 1px dotted">inline style</span></p>
<p><b>B</b>, <strong>STRONG</strong> or <span style="font-weight: bold">inline style</span></p>
<p><em>EM</em>, <i>I</i> or <span style="font-style: italic">inline style</span></p>
<p><u>U</u> or <span style="text-decoration: underline">inline</span> <span style="border-bottom: 1px">style</span></p>
<p><span style="color: #ff0000">Red</span>, <span style="color: #00ff00">green</span>, <span style="color: #0000ff">blue</span></p>
<p>
  <span style="text-decoration: line-through">
    <span style="text-decoration: overline">
      <span style="text-decoration: underline">
        All decorations...
        <span style="text-decoration: none">and none</span>
      </span>
    </span>
  </span>
</p>""",
  """<ul>
  <li>One</li>
  <li>Two</li>
  <li>Three</li>
</ul>""",
  """<ol>
  <li>One</li>
  <li>
    Two
    <ul>
      <li>2.1</li>
      <li>
        2.2
        <ul>
          <li>2.2.1</li>
          <li>2.2.2</li>
        </ul>
      </li>
      <li>2.3</li>
    </ul>
  </li>
  <li>Three</li>
  <li>
    <a href="https://gph.is/QFgPA0"><img src="https://media.giphy.com/media/6VoDJzfRjJNbG/giphy-downsized.gif" /></a>
  </li>
  <li>Five</li>
  <li>Six</li>
  <li>Seven</li>
  <li>Eight</li>
  <li>Nine</li>
  <li>Ten</li>
  <li>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nibh quam, sodales in sollicitudin ut, scelerisque non sapien. Nam nec mi malesuada libero euismod tincidunt sit amet mattis ipsum. Etiam dapibus sem ac accumsan elementum. Vivamus mattis at diam ac pellentesque. Sed id eros condimentum, dignissim risus id, semper enim. Etiam tempor mauris id lorem fringilla, dapibus feugiat enim placerat. In hac habitasse platea dictumst. Nam est felis, accumsan et sapien ac, molestie convallis sapien. Vivamus ligula sapien, ultrices quis nisl ac, blandit hendrerit massa. Maecenas eleifend, nisi eget commodo mollis, elit magna pellentesque odio, sit amet auctor quam nibh vel purus. Integer ultricies lacinia ipsum, in tincidunt erat finibus eget.</li>
</ol>"""
]);

MockString plants = MockString(library: [
  "Beetroot",
  "Chillies",
  "Cowpeas",
  "Cucumber",
  "Small Urban Rotation (50m2)",
  "Sorghum",
  "Tomatoes"
]);

MockString factors = MockString(library: [
  "Skill level",
  "Location",
  "Agro zone",
  "Land size",
  "Soil type",
  "Irrigation",
  "Month",
  "Intention",
  "Sales",
]);